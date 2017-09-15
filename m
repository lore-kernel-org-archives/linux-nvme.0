From: hch@lst.de (Christoph Hellwig)
Date: Fri, 15 Sep 2017 17:42:19 +0200
Subject: [PATCH] nvme/pci: Print invalid SGL only once
In-Reply-To: <20170915154401.GE8878@localhost.localdomain>
References: <1505415974-13489-1-git-send-email-keith.busch@intel.com>
 <20170915145553.GA1147@lst.de> <20170915151713.GD8878@localhost.localdomain>
 <20170915154401.GE8878@localhost.localdomain>
Message-ID: <20170915154219.GB3422@lst.de>

On Fri, Sep 15, 2017@11:44:01AM -0400, Keith Busch wrote:
> I should have known Linux had a macro to do something "once". Is the
> following more acceptable?

This looks much nicer.
