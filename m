From: sagi@grimberg.me (Sagi Grimberg)
Date: Wed, 7 Jun 2017 14:15:21 +0300
Subject: [PATCH v2 2/2] nvme: Add support for FW activation without reset
In-Reply-To: <b398fbce-8425-df4c-4bf2-6095c1da40b5@samsung.com>
References: <1496067391-26143-1-git-send-email-a.dawn@samsung.com>
 <CGME20170529141807epcas1p259e2e9b04327285d18f2d62bb6ccbce1@epcas1p2.samsung.com>
 <1496067498-26233-1-git-send-email-a.dawn@samsung.com>
 <d480fd9e-b002-326d-1ee6-dd0f0694b4e1@grimberg.me>
 <b398fbce-8425-df4c-4bf2-6095c1da40b5@samsung.com>
Message-ID: <d98c8af9-c39b-7a27-bdcc-b90629da5914@grimberg.me>


> Fw_act_timeout is reset to initial state once done.

But you set it before scheduling the delayed work, you either
set it always or you don't (AFACIT)
