From: sagi@grimberg.me (Sagi Grimberg)
Date: Fri, 5 Oct 2018 11:14:50 -0700
Subject: [PATCHv2] nvme/pci: Fix hot removal during error handling
In-Reply-To: <20181005150927.24120-1-keith.busch@intel.com>
References: <20181005150927.24120-1-keith.busch@intel.com>
Message-ID: <d4d7fa23-99b6-de4e-cee5-24205372ac05@grimberg.me>


> -	flush_work(&dev->ctrl.reset_work);
> +	cancel_work_sync(&dev->ctrl.reset_work);

Does reset_work requeue itself? if not I don't fully understand
this change.
