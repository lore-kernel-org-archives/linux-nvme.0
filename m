From: keith.busch@intel.com (Keith Busch)
Date: Tue, 6 Feb 2018 08:05:52 -0700
Subject: [PATCH] nvme-pci: Fix incorrect use of CMB size to calculate
 q_depth
In-Reply-To: <1517869943-3655-1-git-send-email-sbates@raithlin.com>
References: <1517869943-3655-1-git-send-email-sbates@raithlin.com>
Message-ID: <20180206150552.GD31110@localhost.localdomain>

On Mon, Feb 05, 2018@03:32:23PM -0700, sbates@raithlin.com wrote:
>  
> -	if (dev->cmb && (dev->cmbsz & NVME_CMBSZ_SQS)) {
> +	if (dev->cmb && use_cmb_sqes && (dev->cmbsz & NVME_CMBSZ_SQS)) {

Is this a prep patch for something coming later? dev->cmb is already
NULL if use_cmb_sqes is false.
