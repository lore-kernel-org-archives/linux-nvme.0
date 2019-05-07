From: james.smart@broadcom.com (James Smart)
Date: Tue, 7 May 2019 10:04:07 -0700
Subject: [PATCH nvme-cli rfc 1/6] fabrics: ignore arguments that pass in
 "none"
In-Reply-To: <cd812103-3023-4563-2be8-3d22e85e5389@mellanox.com>
References: <20190223023257.21227-1-sagi@grimberg.me>
 <20190223023257.21227-2-sagi@grimberg.me>
 <cd812103-3023-4563-2be8-3d22e85e5389@mellanox.com>
Message-ID: <52aaf112-3460-9fd7-62d4-9a6530b8de48@broadcom.com>



On 5/7/2019 2:17 AM, Max Gurtovoy wrote:
>
> On 2/23/2019 4:32 AM, Sagi Grimberg wrote:
>> As we want to support discovery uevents over different
>> transports, we want to allow the kernel to provide missing
>> information in the form of none and have nvme-cli properly
>> ignore it.
>>
>> One example is the host_traddr. If it is not set (which means
>> that the default route determined the host address) we will
>> want to do the same for newly discovered controllers.
>>
>> So allow users to pass 'none' arguments as well.
>
> can you please add an example for the command in the commit message ?
>

yes, I will in the repost. The real interesting case will come from the 
uevent, which will pass the address argument to the udev event set to 
"none". Therefore the event:
 ? +ACTION=="change", SUBSYSTEM=="nvme", ENV{NVME_EVENT}=="discovery",\
 ? +? ENV{NVME_CTLR_NAME}=="*", ENV{NVME_TRTYPE}=="*", 
ENV{NVME_TRADDR}=="*", \
 ? +? ENV{NVME_TRSVCID}=="*", ENV{NVME_HOST_TRADDR}=="*", \
 ? +? RUN+="/usr/bin/systemctl --no-block start 
nvmf-connect at --device=$env{NVME_CTLR_NAME}\t--transport=$env{NVME_TRTYPE}\t-- 
traddr=$env{NVME_TRADDR}\t--trsvcid=$env{NVME_TRSVCID}\t--host-traddr=$env{NVME_HOST_TRADDR}.service"

will result in:
"/usr/bin/systemctl --no-block start 
nvmf-connect at --device=nvme5\t--transport=none\t-- 
traddr=none\t--trsvcid=none\t--host-traddr=none.service"
or
"/usr/bin/systemctl --no-block start 
nvmf-connect at --device=none\t--transport=fc\t-- 
traddr=nn:aa-bb-cc-dd-00-11-22-33-pn:aa-bb-cc-dd-00-11-22-33\t--trsvcid=none\t--host-traddr=nn:aa-bb-cc-dd-00-11-22-34-pn:aa-bb-cc-dd-00-11-22-34.service"

or similar.


>
>>
>> Signed-off-by: Sagi Grimberg <sagi at grimberg.me>
>> ---
>> ? fabrics.c | 8 ++++----
>> ? 1 file changed, 4 insertions(+), 4 deletions(-)
>>
>> diff --git a/fabrics.c b/fabrics.c
>> index f5cd2127db05..ad9a15e72070 100644
>> --- a/fabrics.c
>> +++ b/fabrics.c
>> @@ -565,7 +565,7 @@ add_argument(char **argstr, int *max_len, char 
>> *arg_str, char *arg)
>> ? {
>> ????? int len;
>> ? -??? if (arg) {
>> +??? if (arg && strcmp(arg, "none")) {
>> ????????? len = snprintf(*argstr, *max_len, ",%s=%s", arg_str, arg);
>> ????????? if (len < 0)
>> ????????????? return -EINVAL;
>> @@ -658,14 +658,14 @@ retry:
>> ????????? return -EINVAL;
>> ????? p += len;
>> ? -??? if (cfg.hostnqn) {
>> +??? if (cfg.hostnqn && strcmp(cfg.hostnqn, "none")) {
>> ????????? len = sprintf(p, ",hostnqn=%s", cfg.hostnqn);
>> ????????? if (len < 0)
>> ????????????? return -EINVAL;
>> ????????? p += len;
>> ????? }
>> ? -??? if (cfg.hostid) {
>> +??? if (cfg.hostid && strcmp(cfg.hostnqn, "none")) {
>
> c&p bug here ?

Yes. that was there in the original. I thought I fixed that.

-- james
