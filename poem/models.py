from django.db import models
from django.urls import reverse
from django.contrib.auth.models import User
from django.core.validators import MinValueValidator, MaxValueValidator


class Holiday(models.Model):
    name = models.CharField('Праздник', max_length=30)
    description = models.TextField(blank=True)
    slug = models.SlugField(max_length=30, unique=True)

    def __str__(self):
        return self.name

    class META:
        verbose_name = 'Праздник'
        verbose_name_plural = 'Праздники'


class Author(models.Model):
    first_name = models.CharField('Имя', max_length=20)
    last_name = models.CharField('Фамилия', max_length=20)
    slug = models.SlugField(max_length=20, unique=True, blank=True)

    def get_url(self):
        return reverse('single_holiday', kwargs={'slug': self.slug})

    def __str__(self):
        return self.last_name

    class Meta:
        verbose_name = 'Автор'
        verbose_name_plural = 'Авторы'


class Poem(models.Model):
    title = models.CharField("Название", max_length=50)
    holiday = models.ForeignKey(Holiday, verbose_name="Праздник", on_delete=models.CASCADE)
    text = models.TextField('Текст')
    time_create = models.DateTimeField(auto_now_add=True)
    time_update = models.DateTimeField(auto_now=True)
    is_published = models.BooleanField("Опубликовано", default=True)
    user = models.ForeignKey(User, verbose_name='Автор', on_delete=models.CASCADE)
    avg_rating = models.FloatField("Средний рейтинг", default=0)
    number_rating = models.IntegerField("Количество оценок", default=0)

    def __str__(self):
        return self.title

    class META:
        verbose_name = 'Стихи'
        verbose_name_plural = 'Стихи'


class Review(models.Model):
    poem = models.ForeignKey(Poem, on_delete=models.CASCADE, verbose_name="Стихи", related_name="reviews")
    review_user = models.ForeignKey(User, on_delete=models.CASCADE)
    rating = models.PositiveIntegerField("Рейтинг", validators=[MinValueValidator(1), MaxValueValidator(5)])
    description = models.CharField("Отзыв", max_length=200, null=True)
    active = models.BooleanField(default=True)
    created = models.DateTimeField(auto_now_add=True)
    update = models.DateTimeField(auto_now=True)

    class META:
        verbose_name = 'Отзыв'
        verbose_name_plural = 'Отзывы'

    def __str__(self):
        return str(self.rating) + " | " + self.poem.title + " | " + str(self.review_user)

