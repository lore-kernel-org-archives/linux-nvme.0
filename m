From: sagig@dev.mellanox.co.il (Sagi Grimberg)
Date: Thu, 11 Feb 2016 14:33:37 +0200
Subject: [PATCH for-4.5 03/13] NVMe: Allow request merges
In-Reply-To: <1455128250-5984-4-git-send-email-keith.busch@intel.com>
References: <1455128250-5984-1-git-send-email-keith.busch@intel.com>
 <1455128250-5984-4-git-send-email-keith.busch@intel.com>
Message-ID: <56BC7FA1.2020101@dev.mellanox.co.il>


> It is generally more efficient to submit larger IO.
>
> Signed-off-by: Keith Busch <keith.busch at intel.com>

Oh yes, I wanted that for some time now, ever since Jens
and I addressed some issues with front merges and gaps which
detected by iser (I had this patch in my pipe but didn't have time to
test...)

Reviewed-by: Sagi Grimberg <sagig at mellanox.com>
