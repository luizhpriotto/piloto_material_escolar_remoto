# Generated by Django 2.2.9 on 2020-12-17 21:21

from django.db import migrations, models


class Migration(migrations.Migration):

    dependencies = [
        ('proponentes', '0017_auto_20200827_1100'),
    ]

    operations = [
        migrations.AddField(
            model_name='loja',
            name='site',
            field=models.URLField(blank=True, null=True),
        ),
    ]
