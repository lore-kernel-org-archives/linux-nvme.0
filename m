From: hch@infradead.org (Christoph Hellwig)
Date: Thu, 23 Feb 2017 02:09:38 -0800
Subject: [PATCH] lpfc: add missing Kconfig NVME dependencies
In-Reply-To: <58adba5f.BoP49Cv2S5zD9ZuD%jsmart2021@gmail.com>
References: <58adba5f.BoP49Cv2S5zD9ZuD%jsmart2021@gmail.com>
Message-ID: <20170223100938.GA20495@infradead.org>

On Wed, Feb 22, 2017@08:20:47AM -0800, James Smart wrote:
> 
> add missing Kconfig NVME dependencies
> 
> Can't believe I missed posting this

Oh.  I'm not sure everyone is happy having to drag in the whole
nvme and nvme target stack when building lpfc.  Is there a way
to make nvme optional?  And in the future scsi as well?
