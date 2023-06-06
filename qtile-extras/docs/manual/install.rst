.. _install:

============
Installation
============

.. note::

    I have no current intentions to package this on PyPi. This means
    installation may be a bit more "manual" than for other packages.

Arch users
==========

This is the easiest option as the package is in the AUR. Using your favourite
helper, you just need to download and install the ``qtile-extras-git`` package.

Alternatively, you can download the `PKGBUILD`_ file from the repo and run ``makepkg -sci``.

.. _PKGBUILD: https://raw.githubusercontent.com/elParaguayo/qtile-extras/main/PKGBUILD

Fedora
======

There is no official package for Fedora yet but you can install it
from `Copr`_::

    dnf copr enable frostyx/qtile
    dnf install qtile-extras

.. _Copr: https://copr.fedorainfracloud.org/

Everyone else
=============

Clone the repo and run ``python setup.py install``.

