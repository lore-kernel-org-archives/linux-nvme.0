From: m@bjorling.me (=?UTF-8?Q?Matias_Bj=C3=B8rling?=)
Date: Tue, 24 Jun 2014 23:18:51 +0200
Subject: [PATCH v8] NVMe: convert to blk-mq
In-Reply-To: <alpine.LRH.2.03.1406241419080.4699@AMR>
References: <1402661396-19207-1-git-send-email-m@bjorling.me>
 <1402661396-19207-2-git-send-email-m@bjorling.me>
 <alpine.LRH.2.03.1406160931400.4699@AMR>
 <53A9CF5F.6040806@bjorling.me>
 <alpine.LRH.2.03.1406241419080.4699@AMR>
Message-ID: <CAOu_J6mz=eeimXAsQ0Mj=tya+eHpwUoiG69=XPWbSEuRO1AwjA@mail.gmail.com>

On Tue, Jun 24, 2014@10:33 PM, Keith Busch <keith.busch@intel.com> wrote:
> On Tue, 24 Jun 2014, Matias Bjorling wrote:
>>
>> Den 16-06-2014 17:57, Keith Busch skrev:
>>>
>>> This latest is otherwise stable on my dev machine.
>>
>>
>> May I add an Acked-by from you?
>
>
> Totally up to Willy, but my feeling is "not just yet". I see the value
> this driver provides, but I would need to give this to a customer and
> hear their results before adding an "ack". It maybe a couple more weeks
> before they'll be able to try it.

I was hoping to get an OK before that, to make sure it is picked up
for the 3.17 release.

Should I pack it up in a specific way to help it along?
