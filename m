From: hch@lst.de (Christoph Hellwig)
Date: Wed, 14 Jun 2017 08:27:00 +0200
Subject: [PATCH] nvme: submit nvme_admin_activate_fw to admin queue
In-Reply-To: <1497389810-19303-1-git-send-email-dmilburn@redhat.com>
References: <1497389810-19303-1-git-send-email-dmilburn@redhat.com>
Message-ID: <20170614062700.GA8929@lst.de>

On Tue, Jun 13, 2017@04:36:50PM -0500, David Milburn wrote:
> The nvme_admin_activate_fw command should be submitted to
> the admin queue; otherwise, mode 0x0F (ACTIVATE_DEFERRED_MICROCODE)
> and mode 0x05 (DOWNLOAD_SAVE_ACTIVATE) will fail.
> 
> Fixes: b90c48d0c11ef("nvme: split nvme_trans_send_fw_cmd")
> Reported-by: Joseph Szczypek <joseph.szczypek at hpe.com>
> Tested-by: Micah Parrish <micah.parrish at hpe.com>
> Signed-off-by: David Milburn <dmilburn at redhat.com>

If this command has been broken all the time we should just remove it.
