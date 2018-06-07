From: keith.busch@linux.intel.com (Keith Busch)
Date: Thu, 7 Jun 2018 08:27:28 -0600
Subject: [PATCH 4/6] nvme-pci: Remove HMB teardown on reset
In-Reply-To: <948d3ec4-20a6-d691-685b-5b85447bbf5f@grimberg.me>
References: <20180606141309.19389-1-keith.busch@intel.com>
 <20180606141309.19389-5-keith.busch@intel.com>
 <948d3ec4-20a6-d691-685b-5b85447bbf5f@grimberg.me>
Message-ID: <20180607142728.GB19462@localhost.localdomain>

On Thu, Jun 07, 2018@11:46:53AM +0300, Sagi Grimberg wrote:
> 
> > The controller is required to disable its host memory buffer use on
> > controller reset.
> 
> You mean clearing controller enable?

Right, clearing CC.EN in nvme spec is a "Controller Reset".
