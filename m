From: logang@deltatee.com (Logan Gunthorpe)
Date: Mon, 19 Dec 2016 10:07:19 -0700
Subject: [RFC 1/1] MicroSemi Switchtec management interface driver
In-Reply-To: <20161219170201.GA1043@localhost.localdomain>
References: <1481994562-9283-1-git-send-email-logang@deltatee.com>
 <1481994562-9283-2-git-send-email-logang@deltatee.com>
 <20161219170201.GA1043@localhost.localdomain>
Message-ID: <8e4b1c0b-04aa-b2ba-21ba-72377913588f@deltatee.com>



On 19/12/16 10:02 AM, Keith Busch wrote:
> Some of this would be simplified if you use the managed device API's:
> devm_request_irq, pcim_enable_device, pcim_iomap, etc...

Thanks Keith, I'll look into using those.

Logan
