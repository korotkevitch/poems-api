from django.contrib import admin
from .models import Holiday, Author, Poem


class HolidayAdmin(admin.ModelAdmin):
    list_display = ['id', 'name', 'description']
    list_display_links = ['id', 'name']
    prepopulated_fields = {'slug': ('name',)}
admin.site.register(Holiday, HolidayAdmin)


class AuthorAdmin(admin.ModelAdmin):
    list_display = ['id', 'first_name', 'last_name']
    list_display_links = ['id', 'last_name']
    prepopulated_fields = {'slug': ('last_name',)}
admin.site.register(Author, AuthorAdmin)


class PoemAdmin(admin.ModelAdmin):
    list_display = ['id', 'holiday', 'text', 'time_create', 'time_update', 'is_published', 'user']
    list_display_links = ['id', 'holiday']
admin.site.register(Poem, PoemAdmin)
