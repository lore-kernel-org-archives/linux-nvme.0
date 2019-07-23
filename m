From: james.smart@broadcom.com (James Smart)
Date: Tue, 23 Jul 2019 09:01:24 -0700
Subject: [PATCH v2 10/10] nvme-cli: nvmf auto-connect scripts
In-Reply-To: <27688d4f-49b1-9fcd-d315-d0a33ecd248d@grimberg.me>
References: <20190719225305.11397-1-jsmart2021@gmail.com>
 <20190719225305.11397-11-jsmart2021@gmail.com>
 <27688d4f-49b1-9fcd-d315-d0a33ecd248d@grimberg.me>
Message-ID: <ec775906-4e87-9455-6989-0152cdcabfd7@broadcom.com>



On 7/22/2019 7:52 PM, Sagi Grimberg wrote:
>
>> Makefile???????????????????????????????????????? | 22 
>> +++++++++++++++++++---
>> ? nvme.spec.in???????????????????????????????????? |? 9 +++++++++
>> ? nvmf-autoconnect/70-nvmf-autoconnect.conf??????? |? 1 +
>> ? nvmf-autoconnect/70-nvmf-autoconnect.rules?????? | 18 
>> ++++++++++++++++++
>> ? nvmf-autoconnect/nvmefc-boot-connections.service |? 9 +++++++++
>> ? nvmf-autoconnect/nvmf-connect.target???????????? |? 2 ++
>> ? nvmf-autoconnect/nvmf-connect at .service?????????? | 14 ++++++++++++++
>> ? 7 files changed, 72 insertions(+), 3 deletions(-)
>> ? create mode 100644 nvmf-autoconnect/70-nvmf-autoconnect.conf
>> ? create mode 100644 nvmf-autoconnect/70-nvmf-autoconnect.rules
>> ? create mode 100644 nvmf-autoconnect/nvmefc-boot-connections.service
>> ? create mode 100644 nvmf-autoconnect/nvmf-connect.target
>> ? create mode 100644 nvmf-autoconnect/nvmf-connect at .service
>
> James, didn't we agree we are going to split these into local
> directories: systemd/ rules/ dracut/ ?
>
> I asked this for us to be able to add more scripts easily that
> would not necessarily be related to autoconnect...

I guess I didn't understand you.? I created separate Make install 
targets for each of those.

-- james
