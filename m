From: sagi@grimberg.me (Sagi Grimberg)
Date: Sun, 30 Oct 2016 08:48:51 +0200
Subject: [PATCH] nvme-loop: kfree(ctrl) on _create() error exit
In-Reply-To: <20161027160017.GA15393@infradead.org>
References: <1477513257-30474-1-git-send-email-james_p_freyensee@linux.intel.com>
 <20161027124906.GA28200@infradead.org>
 <1477582813.2838.11.camel@linux.intel.com>
 <20161027160017.GA15393@infradead.org>
Message-ID: <a14c2c71-b2ec-b713-9c31-e183e0e0d673@grimberg.me>


> The nvmet_ctrl structure is embedded into the nvme_loop_ctrl structure,
> it's not a separate allocation.

oops, was too easy on this one...

reverting from nvmf-4.9-rc...
