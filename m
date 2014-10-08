From: keith.busch@intel.com (Keith Busch)
Date: Wed, 8 Oct 2014 10:13:48 -0600 (MDT)
Subject: [PATCH 4/5] lightnvm: NVMe integration
In-Reply-To: <1412783736-18115-5-git-send-email-m@bjorling.me>
References: <1412783736-18115-1-git-send-email-m@bjorling.me>
 <1412783736-18115-5-git-send-email-m@bjorling.me>
Message-ID: <alpine.LRH.2.03.1410081004310.4688@AMR>

On Wed, 8 Oct 2014, Matias Bj?rling wrote:
> NVMe devices are identified by the vendor specific bits:
>
> Bit 3 in OACS (device-wide). Currently made per device, as the nvme
> namespace is missing in the completion path.

The NVM-Express 1.2 actually defined this bit for Namespace Management,
so I don't think we can use bits the spec marked as "reserved". Maybe
you can trigger off some vendor specific Command Set Supported instead.
