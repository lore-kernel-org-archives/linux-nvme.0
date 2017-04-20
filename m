From: sagi@grimberg.me (Sagi Grimberg)
Date: Thu, 20 Apr 2017 13:20:10 +0300
Subject: [PATCH 2/3] nvme-fabrics: Allow ctrl loss timeout configuration
In-Reply-To: <1c260723-1771-3518-87b1-60d95fa423d8@broadcom.com>
References: <1489876941-6401-1-git-send-email-sagi@grimberg.me>
 <1489876941-6401-3-git-send-email-sagi@grimberg.me>
 <1c260723-1771-3518-87b1-60d95fa423d8@broadcom.com>
Message-ID: <8fcd2b81-15a8-d85d-0fcd-4f7cefaffbfa@grimberg.me>


> I know this patch has been pulled in - but I think it very odd that we
> added a field (nr_reconnects) into the opts structure, that is not an
> connect option but is instead a dynamically-changing transport
> variable.  As the change introduced a common transport variable beyond
> start options, the patch should have formally added a generic transport
> structure to the ctrl structure.

You're correct, I can move it to sit in nvme_ctrl.
