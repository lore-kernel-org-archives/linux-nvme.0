From: hch@infradead.org (Christoph Hellwig)
Date: Wed, 25 Apr 2018 22:33:10 -0700
Subject: NVMeoF Authentication
In-Reply-To: <DE927C68B458BE418D582EC97927A9287FEC86DA@ORSMSX113.amr.corp.intel.com>
References: <DE927C68B458BE418D582EC97927A9287FEC86DA@ORSMSX113.amr.corp.intel.com>
Message-ID: <20180426053310.GA10842@infradead.org>

On Wed, Apr 25, 2018@07:43:05PM +0000, Gruher, Joseph R wrote:
> Hi folks-
> 
> Does the Linux kernel NVMeoF initiator and target implementation support the Authentication Send and Authentication Receive commands from the NVMeoF spec for NVMe in-band authentication?? If not, is there any plan to implement?? Or is some other authentication method (beyond access control list) available?

Just the hostnqn lists.  There currently isn't even any authentification
mechanism specified in NVMe, but a TP to propose one is going to be
posted to the technical working group soon.
