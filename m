From: willy@linux.intel.com (Matthew Wilcox)
Date: Sat, 10 May 2014 22:54:55 -0400
Subject: [PATCH] Remove redundant writes to uncached sqe memory
In-Reply-To: <CAOu_J6ntbk=CxHLk-mea5Jkza=NFgomyZoGmFe+_Zg96tQN5_g@mail.gmail.com>
References: <536D3E3F.9050902@micron.com>
 <CAOu_J6ntbk=CxHLk-mea5Jkza=NFgomyZoGmFe+_Zg96tQN5_g@mail.gmail.com>
Message-ID: <20140511025455.GD6121@linux.intel.com>

On Fri, May 09, 2014@11:14:46PM +0200, Matias Bj?rling wrote:
> I think a description above the declaration of struct nvme_rw_command
> would be helpful. E.g. "If you modify this structure, please change
> nvme_submit_iod accordingly to take care of initialization."

I don't think that's necessary.  There's no hidden gaps in the definition
of nvme_rw_command, so the explicit initialisation of all the fields will
write all of the bytes in the command.
