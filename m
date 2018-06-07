From: hch@lst.de (Christoph Hellwig)
Date: Thu, 7 Jun 2018 15:08:16 +0200
Subject: [PATCH 09/10] nvmet: support configuring ANA groups
In-Reply-To: <2ddf2d48-2b92-624a-eea6-94d1c1ce7136@grimberg.me>
References: <20180606143311.23076-1-hch@lst.de>
 <20180606143311.23076-10-hch@lst.de>
 <2ddf2d48-2b92-624a-eea6-94d1c1ce7136@grimberg.me>
Message-ID: <20180607130816.GA13200@lst.de>

On Thu, Jun 07, 2018@03:58:40PM +0300, Sagi Grimberg wrote:
>> +void nvmet_port_send_ana_event(struct nvmet_port *port)
>> +{
>> +	struct nvmet_subsys_link *p;
>> +
>> +	down_read(&nvmet_config_sem);
>> +	list_for_each_entry(p, &port->subsystems, entry)
>> +		nvmet_send_ana_event(p->subsys);
>> +	up_read(&nvmet_config_sem);
>> +}
>
> Won't this send multiple AENs if a subsystem is exposed via multiple
> ports? (at least in a theoretical case where the host issues a log
> page in between).

Well, we want one AEN per controller always.  Except that this is also
going to send it to controllers on different ports as Hannes already
pointed out.  I'm going to fix that for the next version.
