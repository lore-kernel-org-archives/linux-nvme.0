From: keith.busch@intel.com (Keith Busch)
Date: Fri, 2 Aug 2019 09:50:03 -0600
Subject: [PATCH v3 00/10] nvme-cli: nvmf auto-connect scripts
In-Reply-To: <20190801231348.21397-1-jsmart2021@gmail.com>
References: <20190801231348.21397-1-jsmart2021@gmail.com>
Message-ID: <20190802155003.GB18214@localhost.localdomain>

On Thu, Aug 01, 2019@04:13:38PM -0700, James Smart wrote:
> This is a formal posting of the patches, not an RFC.
> 
> This posting is a combination of the RFC postings of nvme-fc
> auto-connect scripts by Hannes, Sagi, and I. The auto-connect
> scripts are utilized on nvme-fc and for persistent discovery
> controllers that send AENs.  It does not contain the code that
> handles the persistent discovery controller AEN and generates the
> event.
> 
> The auto-connect scripts are now commonized with the exception
> of the nvme-fc boot connections service.  It's expected that both
> the persistent discovery controllers and nvme-fc can post the same
> udev event. Whenever the discovery aen generates an event, the
> new --device=<name> argument will be used to identify the persistent
> discovery controller. When --device is used, the other connect
> attributes will be specified, set to the values of the discovery
> controller, and will be used by the cli to validate the device is
> who it should be or a new discovery controller will be created.
> When nvme-fc generates it's events, it will specify --device=none
> and specify the discovery controller addressing arguments.  If a
> persistent discovery controller exists on nvme-fc, will do nothing
> special and AEN's from it will follow the --device=<name> syntax.
> 
> The udev event handler supports both the new event to be used
> by discovery controllers as well as the existing nvme-fc transport
> event. The nvme-fc transport will be migrated to issue the new
> event syntax. The udev script will continue to support the older
> style nvme-fc event info in case the cli is running against an
> older kernel.

Series looks good to me, patches applied.

We've a lot of new stuff now, I'll plan to tag a release within the next
week if I don't observe or hear of any alarming issues.
