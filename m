From: logang@deltatee.com (Logan Gunthorpe)
Date: Tue, 4 Apr 2017 09:56:48 -0600
Subject: [RFC 2/8] cxgb4: setup pcie memory window 4 and create p2pmem
 region
In-Reply-To: <f269d9e1-8dcf-7970-382e-cb0d9a020efc@grimberg.me>
References: <1490911959-5146-1-git-send-email-logang@deltatee.com>
 <1490911959-5146-3-git-send-email-logang@deltatee.com>
 <f269d9e1-8dcf-7970-382e-cb0d9a020efc@grimberg.me>
Message-ID: <962a8dd8-4d09-0802-9569-00dbf29382d3@deltatee.com>



On 04/04/17 04:42 AM, Sagi Grimberg wrote:
> This is weird, why even call this if !use_p2pmem?

I personally find it cleaner than:

if (use_p2pmem)
	setup_memwin_p2pmem(...)

I'm not sure why that's so weird.

Logan
