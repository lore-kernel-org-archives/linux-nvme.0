From: sagi@grimberg.me (Sagi Grimberg)
Date: Thu, 18 Oct 2018 18:14:48 -0700
Subject: Help needed: nvmet configuration
In-Reply-To: <CABnqofy7bHCUu5n_n+j8bPrCrd7wnfrP3XSapA_UwQWsja6UAg@mail.gmail.com>
References: <CABnqofxasv=-xbQQ+XZH8jad4Oa0gnvKusk5sF_a-kdSLvK1Ww@mail.gmail.com>
 <75a10e13-29fd-df82-0289-b4f6948365c0@grimberg.me>
 <CABnqofwo5xQGnuNTOzC+jsWqUmB-awS6nGWGK4SPPTDp=cFfeA@mail.gmail.com>
 <061df6c2-f1af-41b6-0bcd-5d936b4b41e5@grimberg.me>
 <CABnqofzSqFaNxaU=byG1NGgBXXB_-qX-Zhq7EimwZQT4EN_KBg@mail.gmail.com>
 <CABnqofy7bHCUu5n_n+j8bPrCrd7wnfrP3XSapA_UwQWsja6UAg@mail.gmail.com>
Message-ID: <d80937ab-234f-f180-53de-f00f2014a5ab@grimberg.me>


> Hi Sagi,
> 
> Just wanted to know if you got my earlier message.
> 
> Like I mentioned,? I am able to do "rping" using the interface.
> 
> Do you want me to try out any other thing?
> 

Something is not clear to me, you mention that you are using Mellanox
NIC, but in your original message you probe iw_cxgb4. You should be
loading mlx5_ib.
