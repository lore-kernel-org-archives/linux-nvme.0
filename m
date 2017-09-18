From: keith.busch@intel.com (Keith Busch)
Date: Mon, 18 Sep 2017 14:41:53 -0400
Subject: NVMe and SR-IOV, how to use together?
In-Reply-To: <CAO+XWgkEZZUqFos7ZV7YbO4HtsUnWjARRTnuDTrSOxm_T0_zmw@mail.gmail.com>
References: <CAO+XWgk1o26gj5n-3vszuoQqXzaLjKdevU133X3206FMzxO6rQ@mail.gmail.com>
 <20170918161148.GA310@infradead.org>
 <CAO+XWgkEZZUqFos7ZV7YbO4HtsUnWjARRTnuDTrSOxm_T0_zmw@mail.gmail.com>
Message-ID: <20170918184153.GF17096@localhost.localdomain>

On Mon, Sep 18, 2017@09:20:16PM +0300, Bogdan Rudas wrote:
> I run kernel 4.4.27 which don't have a support for SR-IOV in NVMe
> driver, that's why I do not see a VFs in lspci output.

The driver has nothing to do with what lspci will output. If you don't
see the SR-IOV capability structure there, that means your drive doesn't
support it.
