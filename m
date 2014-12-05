From: keith.busch@intel.com (Keith Busch)
Date: Fri, 5 Dec 2014 15:49:24 +0000 (UTC)
Subject: [PATCH] NVMe: Add SCSI VPD Block Limits Translation
In-Reply-To: <CANvN+emdi6+dW7YQV6+3MqZqwgiwHADTdOVswmN34p24p2U6vQ@mail.gmail.com>
References: <1417738406-517-1-git-send-email-keith.busch@intel.com>
 <CANvN+emdi6+dW7YQV6+3MqZqwgiwHADTdOVswmN34p24p2U6vQ@mail.gmail.com>
Message-ID: <alpine.LNX.2.00.1412051545590.4225@localhost.lm.intel.com>

On Fri, 5 Dec 2014, Andrey Kuzmin wrote:
> On Dec 5, 2014 3:14 AM, "Keith Busch" <keith.busch@intel.com> wrote:
>> -#define INQ_NUM_SUPPORTED_VPD_PAGES                    5
>> +#define INQ_NUM_SUPPORTED_VPD_PAGES                    6
>>  #define VERSION_SPC_4                                  0x06
>>  #define ACA_UNSUPPORTED                                        0
>>  #define STANDARD_INQUIRY_LENGTH                                36
>
> Are there any specific reasons for the above SPC-4 stuff to be defined
> in the nvme driver instead of include/scsi where it seems to
> (naturally) belong? Just my 0.02 :).

There is a lot of scsi cruft in the nvme driver, but I'm sticking to
the local convention here until a refactor (which is coming later!).
