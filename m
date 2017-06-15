From: hch@lst.de (Christoph Hellwig)
Date: Thu, 15 Jun 2017 18:08:56 +0200
Subject: [nvme-4.13 V2] nvme: Implement NS Optimal IO Boundary from 1.3
 Spec
In-Reply-To: <20170615155251.dmmpfcd22vv2ozko@sbauer-Z170X-UD5>
References: <20170615154726.8337-1-scott.bauer@intel.com>
 <20170615155251.dmmpfcd22vv2ozko@sbauer-Z170X-UD5>
Message-ID: <20170615160856.GA26834@lst.de>

On Thu, Jun 15, 2017@09:52:52AM -0600, Scott Bauer wrote:
> I need to re-spin this one more time. I forgot to add the 1.3 version check before accessing the
> register here.

NVMe TPs also apply to older versions, so we should be fine without
the check.
