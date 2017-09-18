From: hch@infradead.org (Christoph Hellwig)
Date: Mon, 18 Sep 2017 09:11:48 -0700
Subject: NVMe and SR-IOV, how to use together?
In-Reply-To: <CAO+XWgk1o26gj5n-3vszuoQqXzaLjKdevU133X3206FMzxO6rQ@mail.gmail.com>
References: <CAO+XWgk1o26gj5n-3vszuoQqXzaLjKdevU133X3206FMzxO6rQ@mail.gmail.com>
Message-ID: <20170918161148.GA310@infradead.org>

SR-IOV itself only allows you to create new virtual functions,
you can look at any number of Linux howtos on creating them using
the sysfs interface.

As far as NVMe is concerned there are multiple levels of interaction
that could be possible, all optional.

First NVMe since version 1.1 supports subsystems with multiple
controlles, and you can use namespace management (if support by the
device) to assign namespaces to one or more controllers.  On Linux
you can use the nvme-cli tool for that.

Since NVMe 1.3 there are virtualization extensions that also allow to
assign resources like queue pairs to specific VMs.  There is no support
in Linux or nvme-cli for that at the moment.
