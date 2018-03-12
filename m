From: keith.busch@intel.com (Keith Busch)
Date: Mon, 12 Mar 2018 12:59:32 -0600
Subject: [PATCH V2] nvme-pci: assign separate irq vectors for adminq and
 ioq0
In-Reply-To: <616adf0c-5023-0e66-cc59-504d52d76e44@oracle.com>
References: <1519832921-13915-1-git-send-email-jianchao.w.wang@oracle.com>
 <CAHp75Vet0gt0RW4eu+TCE8qBSk2ymMKkG5=SuM9ytzO3-6Y+Mg@mail.gmail.com>
 <616adf0c-5023-0e66-cc59-504d52d76e44@oracle.com>
Message-ID: <20180312185932.GH18494@localhost.localdomain>

Hi Jianchao,

The patch tests fine on all hardware I had. I'd like to queue this up
for the next 4.16-rc. Could you send a v3 with the cleanup changes Andy
suggested and a changelog aligned with Ming's insights?

Thanks,
Keith
