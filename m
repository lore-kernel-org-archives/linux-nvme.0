From: sagi@grimberg.me (Sagi Grimberg)
Date: Mon, 22 Oct 2018 23:24:59 -0700
Subject: [PATCH] nvmet:added support for identifying controller list
In-Reply-To: <1540265095-11360-1-git-send-email-lijie34@huawei.com>
References: <1540265095-11360-1-git-send-email-lijie34@huawei.com>
Message-ID: <52246ba4-0b38-b129-edda-e6bc18165e5e@grimberg.me>


> This patch implements the support for identifying controller list and
> namespace attached controller list on the target.

Can you explain why is this needed? Or where is this going?
These are mandatory only for namespace management support which is
not in nvmet.
