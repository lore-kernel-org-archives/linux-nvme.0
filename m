From: jsmart2021@gmail.com (James Smart)
Date: Wed, 29 May 2019 15:27:36 -0700
Subject: [PATCH v2 1/7] nvmet: add transport discovery change op
In-Reply-To: <5e71e7be-3ce0-aa3f-4456-7a6d454a3c7d@grimberg.me>
References: <20190514215808.10572-1-jsmart2021@gmail.com>
 <20190514215808.10572-2-jsmart2021@gmail.com>
 <5e71e7be-3ce0-aa3f-4456-7a6d454a3c7d@grimberg.me>
Message-ID: <72f17092-e068-a13c-9088-59afafcd6157@gmail.com>

On 5/29/2019 3:21 PM, Sagi Grimberg wrote:
> 
>> diff --git a/drivers/nvme/target/discovery.c 
>> b/drivers/nvme/target/discovery.c
>> index 5baf269f3f8a..8efca26b4776 100644
>> --- a/drivers/nvme/target/discovery.c
>> +++ b/drivers/nvme/target/discovery.c
>> @@ -41,6 +41,10 @@ void nvmet_port_disc_changed(struct nvmet_port *port,
>> ????????? __nvmet_disc_changed(port, ctrl);
>> ????? }
>> ????? mutex_unlock(&nvmet_disc_subsys->lock);
>> +
>> +??? /* If transport can signal change, notify transport */
>> +??? if (port->tr_ops && port->tr_ops->discovery_chg)
>> +??????? port->tr_ops->discovery_chg(port);
> 
> So you are shooting for both transport and disc aen to happen
> at the same time?

they could if the discovery controller is a persistent one.

-- james
