From: keith.busch@intel.com (Keith Busch)
Date: Mon, 9 Apr 2018 13:11:10 -0600
Subject: IRQ/nvme_pci_complete_rq: NULL pointer dereference yet again
In-Reply-To: <64cb047e-aa2b-2693-643a-6dac6eba2487@gmail.com>
References: <75edea4e-b961-82a1-3612-fc682a248819@gmail.com>
 <d9497570-5e5e-cc4d-2c63-ff273a48725a@gmail.com>
 <20180406153236.GK10098@localhost.localdomain>
 <94d77cb7-759f-595a-2264-37305dfa96c4@gmail.com>
 <20180406171622.aso3h6ydpmcdizl3@sbauer-Z170X-UD5>
 <93003ab7-f4a0-7e5d-f107-277df20f5566@gmail.com>
 <20180406180445.GL10098@localhost.localdomain>
 <e1218a86-2183-91c9-5a0a-a1c331b5b5f3@gmail.com>
 <20180406220058.GN10098@localhost.localdomain>
 <64cb047e-aa2b-2693-643a-6dac6eba2487@gmail.com>
Message-ID: <20180409191109.GP10098@localhost.localdomain>

On Mon, Apr 09, 2018@01:23:54PM -0500, Alex G. wrote:
> On 04/06/2018 05:00 PM, Keith Busch wrote:
> (snip)
> > ---
> > diff --git a/drivers/pci/pcie/aer/aerdrv_core.c b/drivers/pci/pcie/aer/aerdrv_core.c
> > index a4bfea52e7d4..16ecbcd76373 100644
> > --- a/drivers/pci/pcie/aer/aerdrv_core.c
> > +++ b/drivers/pci/pcie/aer/aerdrv_core.c
> > @@ -805,8 +805,10 @@ void aer_isr(struct work_struct *work)
> >  	struct pcie_device *p_device = rpc->rpd;
> >  	struct aer_err_source uninitialized_var(e_src);
> >  
> > +	pci_lock_rescan_remove();
> >  	mutex_lock(&rpc->rpc_mutex);
> >  	while (get_e_source(rpc, &e_src))
> >  		aer_isr_one_error(p_device, &e_src);
> >  	mutex_unlock(&rpc->rpc_mutex);
> > +	pci_unlock_rescan_remove();
> >  }
> > --
> 
> With this patch, I'm not seeing issues without LVM mirrors, but as soon
> as I enable the mirror, we get the
>  * use-after-free in swiotlb_unmap_sg_attrs
>  * double-free or invalid-free in nvme_pci_complete_rq
> 
> Alex

Awesome, thank you for the update. We'll do some more work on the
above fixing the use-after-free in AER handling to make it ready for
consideration.

Still not sure on the nvme double/incorrect completion, but have not
given up yet.
