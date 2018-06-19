From: keith.busch@linux.intel.com (Keith Busch)
Date: Tue, 19 Jun 2018 08:13:14 -0600
Subject: [PATCH] nvme-cli: Implemented primary and secondary controller
In-Reply-To: <20180618231243.11509-1-revanth.rajashekar@intel.com>
References: <20180618231243.11509-1-revanth.rajashekar@intel.com>
Message-ID: <20180619141313.GB19922@localhost.localdomain>

On Mon, Jun 18, 2018@05:12:43PM -0600, Revanth Rajashekar wrote:
> -struct nvme_id_primary_cntrlr {
> +struct nvme_id_primary_ctrl {

Could you rebase your patch so that it doesn't have dependencies on your
previous version?
