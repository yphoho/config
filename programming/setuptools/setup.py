#!/usr/bin/env python

from setuptools import setup, find_packages

setup(
    name = "helloworld",
    version = "0.1",
    packages = find_packages(),

    entry_points = {
        'console_scripts': [
            'helloworld = helloworld.helloworld:main',
            # 'foo = my_package.some_module:main_func',
            ],
        },

    author = "yphoho",
    author_email = "",
    description = "Python Distribution Utilities",
    license = "GPLv3",
    url = "",
    )

