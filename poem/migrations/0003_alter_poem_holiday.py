# Generated by Django 4.1.2 on 2022-10-20 18:53

from django.db import migrations, models
import django.db.models.deletion


class Migration(migrations.Migration):

    dependencies = [
        ('poem', '0002_holiday_slug_alter_author_slug'),
    ]

    operations = [
        migrations.AlterField(
            model_name='poem',
            name='holiday',
            field=models.ForeignKey(on_delete=django.db.models.deletion.CASCADE, to='poem.holiday', verbose_name='Праздник'),
        ),
    ]