From: jianchao.w.wang@oracle.com (jianchao.wang)
Date: Tue, 13 Mar 2018 09:47:26 +0800
Subject: [PATCH V2] nvme-pci: assign separate irq vectors for adminq and
 ioq0
In-Reply-To: <20180312185932.GH18494@localhost.localdomain>
References: <1519832921-13915-1-git-send-email-jianchao.w.wang@oracle.com>
 <CAHp75Vet0gt0RW4eu+TCE8qBSk2ymMKkG5=SuM9ytzO3-6Y+Mg@mail.gmail.com>
 <616adf0c-5023-0e66-cc59-504d52d76e44@oracle.com>
 <20180312185932.GH18494@localhost.localdomain>
Message-ID: <77263447-ffdd-ebe4-9cf9-8f0b2d9b2503@oracle.com>

Hi Keith

Thanks for your precious time for testing and reviewing.
I will send out V3 next.

Sincerely
Jianchao

On 03/13/2018 02:59 AM, Keith Busch wrote:
> Hi Jianchao,
> 
> The patch tests fine on all hardware I had. I'd like to queue this up
> for the next 4.16-rc. Could you send a v3 with the cleanup changes Andy
> suggested and a changelog aligned with Ming's insights?
> 
> Thanks,
> Keith
> 
