from django.db import models
from django.urls import reverse
from django.contrib.auth.models import User


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
    holiday = models.ForeignKey(Holiday, verbose_name="Праздник", on_delete=models.CASCADE)
    text = models.TextField('Текст')
    time_create = models.DateTimeField(auto_now_add=True)
    time_update = models.DateTimeField(auto_now=True)
    is_published = models.BooleanField(verbose_name='Опубликовано', default=True)
    user = models.ForeignKey(User, verbose_name='Автор', on_delete=models.CASCADE)

    def __unicode__(self):
        return self.holiday

    class META:
        verbose_name = 'Стихи'
        verbose_name_plural = 'Стихи'



