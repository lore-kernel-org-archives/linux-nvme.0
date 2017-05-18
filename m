From: keith.busch@intel.com (Keith Busch)
Date: Thu, 18 May 2017 10:23:46 -0400
Subject: [PATCH nvme-cli] fabrics: add option to override drivers queue
 depth also for connect-all command
In-Reply-To: <81baac81-c2e6-7912-a485-424f9d235fef@suse.de>
References: <20170511174837.17936-1-jthumshirn@suse.de>
 <81baac81-c2e6-7912-a485-424f9d235fef@suse.de>
Message-ID: <20170518142345.GF28520@localhost.localdomain>

On Thu, May 18, 2017@04:10:32PM +0200, Johannes Thumshirn wrote:
> On 05/11/2017 07:48 PM, Johannes Thumshirn wrote:
> > Currently it is not possible to override the fabrics drivers default
> > queue depth with the nvme userspace utility's 'connect-all' command,
> > but only when using the 'connect' command.
> > 
> > Add an option to override the drivers default queue depth for NVMe
> > over fabrics with the 'connect-all' command as we did previouslt with the
> > 'connect' command.
> > 
> > Signed-off-by: Johannes Thumshirn <jthumshirn at suse.de>
> > ---

Thanks, Johnanes, looks good, and applied to the repo.
