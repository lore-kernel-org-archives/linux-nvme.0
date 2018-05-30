From: sagi@grimberg.me (Sagi Grimberg)
Date: Thu, 31 May 2018 02:40:26 +0300
Subject: [PATCHv3 7/9] nvme-pci: Attempt reset retry for IO failures
In-Reply-To: <20180524203500.14081-8-keith.busch@intel.com>
References: <20180524203500.14081-1-keith.busch@intel.com>
 <20180524203500.14081-8-keith.busch@intel.com>
Message-ID: <d81b6cb4-ba05-df56-3b21-e79e9a1a6fc9@grimberg.me>

> If the reset failed due to a non-fatal error, this patch will attempt
> to reset the controller again, with a maximum of 4 attempts.

curious, where did 4 came from?
