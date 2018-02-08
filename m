From: keith.busch@intel.com (Keith Busch)
Date: Thu, 8 Feb 2018 08:15:08 -0700
Subject: [PATCH 2/6] nvme-pci: fix the freeze and quiesce for shutdown
 and reset case
In-Reply-To: <958cae59-1a01-d60f-822b-cf81cfa31b8f@oracle.com>
References: <20180202182413.GH24417@localhost.localdomain>
 <d93d115b-bdb1-24c0-71be-72f1b7563e5a@oracle.com>
 <20180205151314.GP24417@localhost.localdomain>
 <d218f5f5-45f7-6036-00a5-48769101080f@oracle.com>
 <20180206151335.GE31110@localhost.localdomain>
 <e1994613-3cb6-f82b-3296-0f4afdb16314@oracle.com>
 <c5ae0bc0-260e-3a72-5c47-304c0b5034a6@oracle.com>
 <20180207161345.GB1337@localhost.localdomain>
 <1826ebc1-d419-23da-12d4-dd7b1b3fe598@oracle.com>
 <958cae59-1a01-d60f-822b-cf81cfa31b8f@oracle.com>
Message-ID: <20180208151508.GA4797@localhost.localdomain>

On Thu, Feb 08, 2018@10:17:00PM +0800, jianchao.wang wrote:
> There is a dangerous scenario which caused by nvme_wait_freeze in nvme_reset_work.
> please consider it.
> 
> nvme_reset_work
>   -> nvme_start_queues
>   -> nvme_wait_freeze
> 
> if the controller no response, we have to rely on the timeout path.
> there are issues below:
> nvme_dev_disable need to be invoked.
> nvme_dev_disable will quiesce queues, cancel and requeue and outstanding requests.
> nvme_reset_work will hang at nvme_wait_freeze

We used to not requeue timed out commands, so that wasn't a problem
before. Oh well, I'll take a look.
