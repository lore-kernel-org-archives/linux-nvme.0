From: emilne@redhat.com (Ewan D. Milne)
Date: Thu, 15 Feb 2018 14:02:54 -0500
Subject: [PATCH] lpfc: add missing Kconfig NVME dependencies
In-Reply-To: <1518721230.2427.82.camel@localhost.localdomain>
References: <58adba5f.BoP49Cv2S5zD9ZuD%jsmart2021@gmail.com>
 <1518721230.2427.82.camel@localhost.localdomain>
Message-ID: <1518721374.2427.84.camel@localhost.localdomain>

On Thu, 2018-02-15@14:00 -0500, Ewan D. Milne wrote:
> On Wed, 2017-02-22@08:20 -0800, James Smart wrote:
> > add missing Kconfig NVME dependencies
> > 
> > Can't believe I missed posting this
> > 
> > -- james
> > 
> > Signed-off-by: James Smart <james.smart at broadcom.com>
> > ---
> >  drivers/scsi/Kconfig | 1 +
> >  1 file changed, 1 insertion(+)
> > 
> > diff --git a/drivers/scsi/Kconfig b/drivers/scsi/Kconfig
> > index d4023bf..2558434 100644
> > --- a/drivers/scsi/Kconfig
> > +++ b/drivers/scsi/Kconfig
> > @@ -1240,6 +1240,7 @@ config SCSI_LPFC
> >  	tristate "Emulex LightPulse Fibre Channel Support"
> >  	depends on PCI && SCSI
> >  	depends on SCSI_FC_ATTRS
> > +	depends on NVME_FC && NVME_TARGET_FC
> >  	select CRC_T10DIF
> >  	help
> >            This lpfc driver supports the Emulex LightPulse
> 
> I thought this was why you had
> 
> #if (IS_ENABLED(CONFIG_NVME_FC))
> #if (IS_ENABLED(CONFIG_NVME_TARGET_FC))
> 
> at various places in the lpfc driver.  Do you actually depend
> on having NVME_FC and NVME_TARGET_FC, or do you selectively
> include code if they are config'ed in?
> 
> Or do you want to force-enable it at this point?
> 
> -Ewan
> 

Sorry, never mind, accidentally to very old mail message.
