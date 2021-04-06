# Generated by Django 2.2.9 on 2020-07-13 17:19

from django.db import migrations, models


class Migration(migrations.Migration):

    dependencies = [
        ('proponentes', '0005_auto_20200710_1508'),
    ]

    operations = [
        migrations.AddField(
            model_name='proponente',
            name='end_bairro',
            field=models.CharField(blank=True, max_length=100, verbose_name='bairro'),
        ),
        migrations.AddField(
            model_name='proponente',
            name='end_complemento',
            field=models.CharField(blank=True, max_length=100, verbose_name='complemento'),
        ),
        migrations.AddField(
            model_name='proponente',
            name='end_numero',
            field=models.CharField(blank=True, max_length=20, verbose_name='número'),
        ),
    ]