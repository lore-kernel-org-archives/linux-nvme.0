From: james.smart@broadcom.com (James Smart)
Date: Sun, 14 Jul 2019 07:47:35 -0700
Subject: [PATCH rfc v2 10/10] nvme-cli: nvmf auto-connect scripts
In-Reply-To: <a97cd8d1-b36f-828f-12b7-975d3fe219ca@grimberg.me>
References: <20190712003140.16221-1-jsmart2021@gmail.com>
 <20190712003140.16221-11-jsmart2021@gmail.com>
 <a97cd8d1-b36f-828f-12b7-975d3fe219ca@grimberg.me>
Message-ID: <e57dd0cb-2ef0-4705-083a-ac81cffeb0d2@broadcom.com>



On 7/12/2019 10:26 AM, Sagi Grimberg wrote:
>
>> +ExecStart=/bin/sh -c "/usr/sbin/nvme connect-all `/usr/bin/echo -e 
>> $CONNECT_ARGS`"
>
> Lets lose the nvme full path, sh allows us to have that (can be in
> /usr/local/sbin or somewhere else). and not /bin/echo?

For nvme, echo or both ?
