defmodule DbuniverseWeb.InputHelpers do
    
    use Phoenix.HTML

    def image_url_input(form, field, label) do
        
        type = Phoenix.HTML.Form.input_type(form, field)
        
        wrapper_opts = [class: "form-group"]
        label_opts = [class: "control-label"]
        input_opts = [class: "form-control"]
        img_opts = [id: "img-url"]

        content_tag :div, wrapper_opts do

            label = label(form, field, label, label_opts)
            input = apply(Phoenix.HTML.Form, type, [form, field, input_opts])
            img = img_tag(form.params["image_url"], img_opts)
            
            [label, input, img]

        end
        

    end

end