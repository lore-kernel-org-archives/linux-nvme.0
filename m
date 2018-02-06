From: sbates@raithlin.com (Stephen  Bates)
Date: Tue, 6 Feb 2018 15:56:21 +0000
Subject: [PATCH] nvme-pci: Fix incorrect use of CMB size to calculate
 q_depth
In-Reply-To: <20180206150552.GD31110@localhost.localdomain>
References: <1517869943-3655-1-git-send-email-sbates@raithlin.com>,
 <20180206150552.GD31110@localhost.localdomain>
Message-ID: <6ECB1B8A-A08D-466D-BD04-297ED26738E8@raithlin.com>


> On Feb 6, 2018,@8:02 AM, Keith Busch <keith.busch@intel.com> wrote:
> 
>> On Mon, Feb 05, 2018@03:32:23PM -0700, sbates@raithlin.com wrote:
>> 
>> -    if (dev->cmb && (dev->cmbsz & NVME_CMBSZ_SQS)) {
>> +    if (dev->cmb && use_cmb_sqes && (dev->cmbsz & NVME_CMBSZ_SQS)) {
> 
> Is this a prep patch for something coming later? dev->cmb is already
> NULL if use_cmb_sqes is false.

Thanks Keith. 

Not sure how I missed this. I was working on OOT patches to enable WDS and RDS in the CMB. I *thought* I?d confirmed this patch was applicable to upstream. Looks like I did not do that correctly. 

Sorry for the churn. We can leave this patch out for now. Thanks for the prompt feedback everyone!

Stephen 
