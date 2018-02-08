From: sagi@grimberg.me (Sagi Grimberg)
Date: Thu, 8 Feb 2018 17:42:06 +0200
Subject: [PATCH v3 2/2] Documentation: nvme: Documentation for nvme fault
 injection
In-Reply-To: <1517526659-3450-3-git-send-email-thomas.tai@oracle.com>
References: <1517526659-3450-1-git-send-email-thomas.tai@oracle.com>
 <1517526659-3450-3-git-send-email-thomas.tai@oracle.com>
Message-ID: <75fba2c9-3fb6-0cf8-fcf4-7738bd7c6147@grimberg.me>


> +o NVMe fault injection
> +
> +  inject NVMe NVME_SC_INVALID_OPCODE with no retry on devices permitted
> +  by setting debugfs entries under /sys/kernel/debug/nvme*/fault_inject
> +

Actually, can you update the documentation entry here?
