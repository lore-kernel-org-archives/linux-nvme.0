From: keith.busch@intel.com (Keith Busch)
Date: Fri, 9 Feb 2018 10:12:31 -0700
Subject: [PATCH V2 0/6]nvme-pci: fixes on nvme_timeout and nvme_dev_disable
In-Reply-To: <db5fe34b-3ffb-a658-d4d6-a1c619b2d590@oracle.com>
References: <1517822415-11710-1-git-send-email-jianchao.w.wang@oracle.com>
 <073ce416-fd26-b41a-187d-1db9210c48b0@grimberg.me>
 <20180208175606.GD5039@localhost.localdomain>
 <db5fe34b-3ffb-a658-d4d6-a1c619b2d590@oracle.com>
Message-ID: <20180209171231.GB6970@localhost.localdomain>

On Fri, Feb 09, 2018@09:50:58AM +0800, jianchao.wang wrote:
> 
> if we set NVME_REQ_CANCELLED and return BLK_EH_HANDLED as the RESETTING case,
> nvme_reset_work will hang forever, because no one could complete the entered requests.

Except it's no longer in the "RESETTING" case since you added the
"CONNECTING" state, so that's already broken for other reasons...
