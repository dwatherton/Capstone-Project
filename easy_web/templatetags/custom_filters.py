from django import template

register = template.Library()


@register.filter(name='replace_underscores')
def replace_underscores(string):
    return string.replace('_', ' ')
