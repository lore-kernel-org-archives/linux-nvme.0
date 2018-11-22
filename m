From: sagi@grimberg.me (Sagi Grimberg)
Date: Wed, 21 Nov 2018 18:57:48 -0800
Subject: [PATCH] drivers/nvme/host/rdma.c: Fix double freeing of async
 event data
In-Reply-To: <CAL1RGDWGs6E5nPUJEc73wuMjnUP-aEM62MywyT6X_fK4Tbj1Gw@mail.gmail.com>
References: <1542744673-28129-1-git-send-email-psajeepa@purestorage.com>
 <CAL1RGDXrdn1krOyoVMVuRRuuAv8HSNHMusuwq2Evg9fDCGJN8A@mail.gmail.com>
 <47965bbe-ef63-eb54-60e3-b2662ae82e8f@grimberg.me>
 <CAE=VkfB4G8PFZuNihQR0fei9BSr5ayqOrMWjFq9Xo5anQNgk7w@mail.gmail.com>
 <CAL1RGDXXKvg+n-QfMZoHp8By81seMW7YatQ0RXD3JnAe_eFDXg@mail.gmail.com>
 <CAE=VkfBvD9gG3MuwptCdpZso3t0JsFTvO-s1q+aW9=Zm4QTR=Q@mail.gmail.com>
 <CAL1RGDWGs6E5nPUJEc73wuMjnUP-aEM62MywyT6X_fK4Tbj1Gw@mail.gmail.com>
Message-ID: <71ba474f-527f-fb67-5b7e-9b0ffc17a01c@grimberg.me>


> <psajeepa@purestorage.com> wrote:
>> Yes, we need to set qe->data to NULL in alloc_qe failure path as well.
>> I was suggesting setting of qe->data to NULL in nvme_rdma_free_qe() in addition to the fix suggested by you.
> 
> I'm ambivalent, I think either way of handling clearing data after
> free_qe is fine.  Two out of the three calls to free_qe need the "set
> to NULL", so I personally don't have a strong feeling about whether
> open-coding the data=NULL or putting it in the free function is
> better.

How about simply NULLing for the specific flow that Roland spotted in
addition to yours?
