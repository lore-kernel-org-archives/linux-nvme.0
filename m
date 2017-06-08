From: hch@lst.de (Christoph Hellwig)
Date: Thu, 8 Jun 2017 09:57:22 +0200
Subject: [PATCH v6 05/10] nvmet: implement namespace identify
 descriptor list
In-Reply-To: <7ffdc123-c43b-dff0-73bf-4e876ece323e@suse.de>
References: <20170607094536.32419-1-jthumshirn@suse.de>
 <20170607094536.32419-6-jthumshirn@suse.de> <20170608074414.GD13953@lst.de>
 <ac55e56a-a47e-1e53-c537-b940de99c746@suse.de>
 <20170608075209.GA14359@lst.de>
 <7ffdc123-c43b-dff0-73bf-4e876ece323e@suse.de>
Message-ID: <20170608075722.GA14453@lst.de>

On Thu, Jun 08, 2017@09:55:37AM +0200, Johannes Thumshirn wrote:
> Btw, is the NVMf sleftests still avtively developed? If yes I have a
> testcase for this series (not sure this qualifies for blktests)

As-is it's pretty dead, but Chaitanya has been looking into resurrecting
it in a modern form.  Which reminds me that I owe him an offlist review
on what he has so far, let me get to that ASAP..
