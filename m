From: hch@infradead.org (Christoph Hellwig)
Date: Sun, 8 Jan 2017 06:09:11 -0800
Subject: [PATCH v4 4/6] block: Add Opal Files to Makefile & add config
 option to Kconfig
In-Reply-To: <1483039615-22407-5-git-send-email-scott.bauer@intel.com>
References: <1483039615-22407-1-git-send-email-scott.bauer@intel.com>
 <1483039615-22407-5-git-send-email-scott.bauer@intel.com>
Message-ID: <20170108140911.GB25986@infradead.org>

> +config BLK_SED_OPAL
> +        bool "Library for interfacing with Opal enabled SEDs"
> +	default n
> +	---help---
> +	Builds library for interfacing with Opal enabled controllers.
> +

Inconsistant whitespaces here, kust use tabs.  The defauly n is the
defaul, so it could be dropped.  Maybe the help text could be expanded
a bit, including explining what SED stands for (I know, but many
potential users don't), and de-emphasis the library part.

E.g. something like

config BLK_SED_OPAL
	bool "Support for OPAL Self Encrypting Drives"
	help
	  This optional enables support for Self Encrypting Drives
	  using the TCG OPAL protocol family.
