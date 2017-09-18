From: brudas@exadel.com (Bogdan Rudas)
Date: Mon, 18 Sep 2017 21:20:16 +0300
Subject: NVMe and SR-IOV, how to use together?
In-Reply-To: <20170918161148.GA310@infradead.org>
References: <CAO+XWgk1o26gj5n-3vszuoQqXzaLjKdevU133X3206FMzxO6rQ@mail.gmail.com>
 <20170918161148.GA310@infradead.org>
Message-ID: <CAO+XWgkEZZUqFos7ZV7YbO4HtsUnWjARRTnuDTrSOxm_T0_zmw@mail.gmail.com>

I run kernel 4.4.27 which don't have a support for SR-IOV in NVMe
driver, that's why I do not see a VFs in lspci output.

Thank you.

On Mon, Sep 18, 2017@7:11 PM, Christoph Hellwig <hch@infradead.org> wrote:
> SR-IOV itself only allows you to create new virtual functions,
> you can look at any number of Linux howtos on creating them using
> the sysfs interface.
>
> As far as NVMe is concerned there are multiple levels of interaction
> that could be possible, all optional.
>
> First NVMe since version 1.1 supports subsystems with multiple
> controlles, and you can use namespace management (if support by the
> device) to assign namespaces to one or more controllers.  On Linux
> you can use the nvme-cli tool for that.
>
> Since NVMe 1.3 there are virtualization extensions that also allow to
> assign resources like queue pairs to specific VMs.  There is no support
> in Linux or nvme-cli for that at the moment.



-- 
Bogdan Rudas
Director of IT Europe
Exadel Inc.
http://www.exadel.com/
E-mail: brudas at exadel.com
Skype ID: bogdan.rudas

-- 


CONFIDENTIALITY NOTICE: This email and files attached to it are 
confidential. If you are not the intended recipient you are hereby notified 
that using, copying, distributing or taking any action in reliance on the 
contents of this information is strictly prohibited. If you have received 
this email in error please notify the sender and delete this email.
