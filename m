From: sagi@grimberg.me (Sagi Grimberg)
Date: Fri, 24 May 2019 01:08:20 -0700
Subject: [PATCH RFC 0/4] nvmet: add support for port based io priority
In-Reply-To: <20190517094545.GA26412@infradead.org>
References: <20190516032109.13048-1-chaitanya.kulkarni@wdc.com>
 <20190517094545.GA26412@infradead.org>
Message-ID: <8e9ff434-f682-a2be-bc10-a906f793cc24@grimberg.me>


>> Any feedback is welcome, I'd like to understand if this approach is desirable,
>> if not then what is the right way to use the io priorities on that target side
>> so that NVMeOF target can take advantage of the scheduler infrastructure ?
> 
> I don't really see the point.  Why would we treat I/O differently
> depending on which port it came into?

Agree this seems somewhat sketchy...

I don't understand what is the usage model at all.
