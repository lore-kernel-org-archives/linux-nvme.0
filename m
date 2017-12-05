From: guanjunxiong@huawei.com (Guan Junxiong)
Date: Tue, 5 Dec 2017 08:38:20 +0800
Subject: [PATCH 1/2] nvme-cli: add support to get properties for NVMe over
 Fabric
In-Reply-To: <CAA7jztfY_hbngB+5jEx7aDc9qBQtpQpB7rzNSGYtd6EiV7tcsQ@mail.gmail.com>
References: <1512396404-18872-1-git-send-email-guanjunxiong@huawei.com>
 <1512396404-18872-2-git-send-email-guanjunxiong@huawei.com>
 <CAA7jztfY_hbngB+5jEx7aDc9qBQtpQpB7rzNSGYtd6EiV7tcsQ@mail.gmail.com>
Message-ID: <fb36199a-f540-a157-d695-60bbb7ed75d9@huawei.com>

Hi Minwoo,

On 2017/12/4 23:46, Minwoo Im wrote:
> HI Guan,
> 
>> +int nvme_property(int fd, __u8 fctype, __le32 off, __le64 *value, __u8 attrib)
>> +{
>> +       int err;
>> +       struct nvmf_property_get_command *prop_get_cmd;
>> +       struct nvmf_property_set_command *prop_set_cmd;
>> +       struct nvme_admin_cmd cmd = {
>> +               .opcode         = nvme_fabrics_command,
>> +       };
>> +
>> +       if (!value)
>> +               return EINVAL;
>                               ^^^^^^^^
> A caller that included in another patch is expecting it to be a negative value
> like -EINVAL. A caller will recognize this positive value as NVMe status.
> It should be returned as a negative when it's about Linux error code.
> 

This convention is complied in the kernel side, but when I check options of the nvme-cli
, this convention is not always complied. Most of them uses the positive Linux error code.
On the other side, the NVMe error status code returned from kernel can be distinguished
by the highest bit.

> 
>> +       if (fctype == nvme_fabrics_type_property_get){
>> +               prop_get_cmd = (struct nvmf_property_get_command *)&cmd;
>> +               prop_get_cmd->fctype = nvme_fabrics_type_property_get;
>> +               prop_get_cmd->offset = off;
>> +               prop_get_cmd->attrib = attrib;
>> +       }
>> +       else if(fctype == nvme_fabrics_type_property_set) {
>> +               prop_set_cmd = (struct nvmf_property_set_command *)&cmd;
>> +               prop_set_cmd->fctype = nvme_fabrics_type_property_set;
>> +               prop_set_cmd->offset = off;
>> +               prop_set_cmd->attrib = attrib;
>> +               prop_set_cmd->value = *value;
>> +       }
>> +       else return EINVAL;
>                               ^^^^^^^^
> Same as above.
> 
> 
>> +
>> +       err = nvme_submit_admin_passthru(fd, &cmd);
>> +       if (!err && fctype == nvme_fabrics_type_property_get) {
>> +               *value = cpu_to_le64(cmd.result);
>> +       }
>> +
>> +       return err;
>> +}
>> +
>> +int nvme_get_properties(int fd, void **pbar)
>> +{
>> +       __le64 value64;
>> +       __le32 off;
>> +       int err, ret = EINVAL;
>                             ^^^^^^^^^^
> Should it be a negative value?
> 
> 
>> +       bool is64bit = false;
>                                 ^^^^^^
> Initialization seems unnecessary because it will be set properly
> before getting used.
> 

Agreed, thanks.

> 
>>  static void *get_registers(void)
>>  {
>> -       int pci_fd;
>> +       int fd;
>>         char *base, path[512];
>>         void *membase;
>>
>>         base = nvme_char_from_block((char *)devicename);
>>         sprintf(path, "/sys/class/nvme/%s/device/resource0", base);
>> -       pci_fd = open(path, O_RDONLY);
>> -       if (pci_fd < 0) {
>> +       fd = open(path, O_RDONLY);
>> +       if (fd < 0) {
>>                 sprintf(path, "/sys/class/misc/%s/device/resource0", base);
>> -               pci_fd = open(path, O_RDONLY);
>> +               fd = open(path, O_RDONLY);
>>         }
>> -       if (pci_fd < 0) {
>> +       if (fd < 0) {
>>                 fprintf(stderr, "%s did not find a pci resource\n", base);
>>                 return NULL;
>>         }
>>
>> -       membase = mmap(NULL, getpagesize(), PROT_READ, MAP_SHARED, pci_fd, 0);
>> +       membase = mmap(NULL, getpagesize(), PROT_READ, MAP_SHARED, fd, 0);
>>         if (membase == MAP_FAILED) {
>>                 fprintf(stderr, "%s failed to map\n", base);
>>                 return NULL;
> 
> Is this code you intended? This code looks showing some changes only
> just for re-naming.
> I'm just asking if this change point should be included in this patch
> set or not.
> 

It should be. fd means it can be pci_fd or nvmf_fd.

> If you think I misunderstood what you have intended, or went wrong,
> please let me know.
> 

Thanks.
Guan
.
