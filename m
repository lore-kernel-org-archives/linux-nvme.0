From: hch@infradead.org (Christoph Hellwig)
Date: Sun, 8 Jan 2017 06:06:47 -0800
Subject: [PATCH v4 3/6] block: add ioctl interface for interfacing with
 Opal library
In-Reply-To: <1483039615-22407-4-git-send-email-scott.bauer@intel.com>
References: <1483039615-22407-1-git-send-email-scott.bauer@intel.com>
 <1483039615-22407-4-git-send-email-scott.bauer@intel.com>
Message-ID: <20170108140647.GA25986@infradead.org>

Given that by now these are OPAL-family specific I'd just merge this file
into sed-opal.c.  That why all the ioctl implementation functions can
become static in that file, and only sed_ioctl needs to be exported to
the drivers.
