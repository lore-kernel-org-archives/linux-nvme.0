From: keith.busch@intel.com (Keith Busch)
Date: Mon, 26 May 2014 18:56:50 -0600 (MDT)
Subject: [PATCH] NVMe: Add support to receive NVMe asynchronous events
In-Reply-To: <20140526235156.GS6121@linux.intel.com>
References: <53839E67.1010006@micron.com>
 <20140526235156.GS6121@linux.intel.com>
Message-ID: <alpine.LRH.2.03.1405261834070.4700@AMR>

On Mon, 26 May 2014, Matthew Wilcox wrote:
> You should probably take a look at Keith's work last year to allow userspace
> to send async event requests:
>
> http://lists.infradead.org/pipermail/linux-nvme/2013-August/000350.html

Yeah, that proposal just lets userspace consume the results of an async
request from a FIFO read through the character device. The driver still
has to do the sending since there's no mechanism for requests from user
space with infinite timeout.

I've no idea if the proposed method for consuming results of this kind
of information was typical. I assumed it wasn't since it didn't get much
traction. :)
