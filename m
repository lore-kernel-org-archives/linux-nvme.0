From: hch@infradead.org (Christoph Hellwig)
Date: Thu, 7 Jan 2016 10:54:47 -0800
Subject: [PATCHv3 4/5] NVMe: IO queue deletion re-write
In-Reply-To: <20160106195112.GB20732@localhost.localdomain>
References: <1451923859-14187-1-git-send-email-keith.busch@intel.com>
 <1451923859-14187-5-git-send-email-keith.busch@intel.com>
 <20160106130419.GA23245@infradead.org>
 <20160106195112.GB20732@localhost.localdomain>
Message-ID: <20160107185447.GA30417@infradead.org>

On Wed, Jan 06, 2016@07:51:12PM +0000, Keith Busch wrote:
> Now I actually ran with the proposal and found this minor opcode
> oversight. Should be:
> 
> +	cmd.delete_queue.opcode = opcode;
> 
> After that, it's successful.

Ok.  Feel free to fold the whole thing into your original patch.
