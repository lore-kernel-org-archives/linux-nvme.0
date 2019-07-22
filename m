From: sagi@grimberg.me (Sagi Grimberg)
Date: Mon, 22 Jul 2019 15:43:43 -0700
Subject: [PATCH v2 00/10] nvme-cli: nvmf auto-connect scripts
In-Reply-To: <20190719225305.11397-1-jsmart2021@gmail.com>
References: <20190719225305.11397-1-jsmart2021@gmail.com>
Message-ID: <226c6913-cda8-e692-4dfb-a6714592ed53@grimberg.me>

> This is a formal posting of the patches, not an RFC.

I think we are good to go here.

Keith,
We will probably pick up the kernel component as soon as
we create nvme-5.4 tree. I think its safe to get these in
as is to nvme-cli. It's transparent to the existing usage
and will not be triggered without the kernel firing uevents.
