From: hch@infradead.org (Christoph Hellwig)
Date: Fri, 9 Dec 2016 10:30:34 -0800
Subject: [PATCH v2 2/4] block: Add Sed-opal library
In-Reply-To: <20161209174529.GA7865@sbauer-Z170X-UD5>
References: <1480456322-27339-1-git-send-email-scott.bauer@intel.com>
 <1480456322-27339-3-git-send-email-scott.bauer@intel.com>
 <20161201005006.GE21081@localhost.localdomain>
 <20161201100456.GA17592@infradead.org>
 <20161201175343.GA6554@sbauer-Z170X-UD5>
 <20161201182239.GH21081@localhost.localdomain>
 <20161209174529.GA7865@sbauer-Z170X-UD5>
Message-ID: <20161209183034.GA28669@infradead.org>

On Fri, Dec 09, 2016@10:45:30AM -0700, Scott Bauer wrote:
> Now, with this in mind, it sort of makes sense to move this from
> block/ back into lib/ and interface with the character dev. Instead
> of passing around block_devices, we can pass around struct file *'s.
>

Even the character device is always backed by the queues, and I'd really
not prefer to have a struct file here - that's not useful at all
for in-kernel users.
